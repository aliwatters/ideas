#!/usr/bin/env python3
"""
Domain availability checker using whois lookups.
"""

import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

DOMAINS = [
    # Fireside
    "firesidetales.com", "firesidefables.com", "firesidestories.com",
    "firesidelore.com", "firesidemyths.com", "firesidechronicles.com",
    "firesidelegends.com", "firesideechoes.com", "firesidewhispers.com",
    "firesidemurmurs.com",

    # Hearth
    "hearthtales.com", "hearthfables.com", "hearthstories.com",
    "hearthlore.com", "hearthmyths.com", "hearthchronicles.com",
    "hearthlegends.com", "hearthechoes.com", "hearthwhispers.com",
    "hearthmurmurs.com",

    # Hearthlight
    "hearthlighttales.com", "hearthlightfables.com", "hearthlightstories.com",
    "hearthlightlore.com", "hearthlightmyths.com", "hearthlightchronicles.com",
    "hearthlightlegends.com", "hearthlightechoes.com", "hearthlightwhispers.com",
    "hearthlightmurmurs.com",

    # Ember
    "embertales.com", "emberfables.com", "emberstories.com",
    "emberlore.com", "embermyths.com", "emberchronicles.com",
    "emberlegends.com", "emberechoes.com", "emberwhispers.com",
    "embermurmurs.com",

    # Emberlight
    "emberlighttales.com", "emberlightfables.com", "emberlightstories.com",
    "emberlightlore.com", "emberlightmyths.com", "emberlightchronicles.com",
    "emberlightlegends.com", "emberlightechoes.com", "emberlightwhispers.com",
    "emberlightmurmurs.com",

    # Ember and
    "emberandstory.com", "emberandlore.com",

    # Firelight
    "firelighttales.com", "firelightfables.com", "firelightstories.com",
    "firelightlore.com", "firelightmyths.com", "firelightchronicles.com",
    "firelightlegends.com", "firelightechoes.com", "firelightwhispers.com",
    "firelightmurmurs.com",

    # Fire and
    "fireandtale.com", "fireandstory.com", "fireandlore.com",
    "fireandmyth.com", "fireandfable.com",

    # The *
    "thefirelightstory.com", "thefiresidechronicle.com", "thefiresidestory.com",
    "thehearthchronicle.com", "thehearthstory.com", "theemberchronicle.com",
    "theemberstory.com", "theemberfable.com", "theembertale.com",
    "theemberchronicles.com", "thehearthandstory.com", "thehearthandtale.com",
    "thehearthandlore.com",

    # Candlelight
    "candlelighttales.com", "candlelightfables.com", "candlelightstories.com",
    "candlelightlore.com", "candlelightmyths.com", "candlelightchronicles.com",
    "candlelightlegends.com", "candlelightechoes.com", "candlelightwhispers.com",
    "candlelightmurmurs.com",

    # Lantern
    "lanterntales.com", "lanternfables.com", "lanternstories.com",
    "lanternlore.com", "lanternmyths.com", "lanternchronicles.com",
    "lanternlegends.com", "lanternechoes.com", "lanternwhispers.com",
    "lanternmurmurs.com",

    # Lanternlight
    "lanternlighttales.com", "lanternlightfables.com", "lanternlightstories.com",
    "lanternlightlore.com", "lanternlightmyths.com", "lanternlightchronicles.com",
    "lanternlightlegends.com", "lanternlightechoes.com", "lanternlightwhispers.com",
    "lanternlightmurmurs.com",

    # Glowfire
    "glowfiretales.com", "glowfirefables.com", "glowfirestories.com",
    "glowfirelore.com", "glowfiremyths.com", "glowfirechronicles.com",
    "glowfirelegends.com", "glowfireechoes.com", "glowfirewhispers.com",
    "glowfiremurmurs.com",

    # Glowlight
    "glowlighttales.com", "glowlightfables.com", "glowlightstories.com",
    "glowlightlore.com", "glowlightmyths.com", "glowlightchronicles.com",
    "glowlightlegends.com", "glowlightechoes.com", "glowlightwhispers.com",
    "glowlightmurmurs.com",
]

# Indicators that a domain is NOT registered (available)
AVAILABLE_INDICATORS = [
    "no match",
    "not found",
    "no data found",
    "domain not found",
    "no entries found",
    "no object found",
    "status: free",
    "status: available",
    "is available",
]

# Indicators that a domain IS registered (taken)
TAKEN_INDICATORS = [
    "domain status:",
    "registrar:",
    "creation date:",
    "registry expiry date:",
    "name server:",
]


def check_domain_whois(domain: str) -> dict:
    """Check domain availability using whois."""
    result = {
        "domain": domain,
        "available": None,
        "error": None,
        "raw_output": None,
    }

    try:
        proc = subprocess.run(
            ["whois", domain],
            capture_output=True,
            text=True,
            timeout=30,
        )
        output = proc.stdout.lower()
        result["raw_output"] = proc.stdout[:500]  # Store first 500 chars for debugging

        # Check for availability indicators
        for indicator in AVAILABLE_INDICATORS:
            if indicator in output:
                result["available"] = True
                return result

        # Check for taken indicators
        for indicator in TAKEN_INDICATORS:
            if indicator in output:
                result["available"] = False
                return result

        # If we can't determine, mark as unknown
        result["available"] = None
        result["error"] = "Could not determine status"

    except subprocess.TimeoutExpired:
        result["error"] = "Timeout"
    except Exception as e:
        result["error"] = str(e)

    return result


def main():
    print(f"Checking {len(DOMAINS)} domains...\n")

    available = []
    taken = []
    unknown = []
    errors = []

    # Use thread pool for parallel lookups (but limit to avoid rate limiting)
    with ThreadPoolExecutor(max_workers=3) as executor:
        future_to_domain = {
            executor.submit(check_domain_whois, domain): domain
            for domain in DOMAINS
        }

        completed = 0
        for future in as_completed(future_to_domain):
            completed += 1
            result = future.result()
            domain = result["domain"]

            if result["error"]:
                errors.append(result)
                status = f"ERROR: {result['error']}"
            elif result["available"] is True:
                available.append(domain)
                status = "AVAILABLE"
            elif result["available"] is False:
                taken.append(domain)
                status = "TAKEN"
            else:
                unknown.append(result)
                status = "UNKNOWN"

            print(f"[{completed}/{len(DOMAINS)}] {domain}: {status}")

            # Small delay to avoid rate limiting
            time.sleep(0.5)

    # Print summary
    print("\n" + "=" * 60)
    print("SUMMARY")
    print("=" * 60)

    print(f"\n AVAILABLE DOMAINS ({len(available)}):")
    print("-" * 40)
    for domain in sorted(available):
        print(f"  {domain}")

    print(f"\n TAKEN DOMAINS ({len(taken)}):")
    print("-" * 40)
    for domain in sorted(taken):
        print(f"  {domain}")

    if unknown:
        print(f"\n UNKNOWN STATUS ({len(unknown)}):")
        print("-" * 40)
        for result in unknown:
            print(f"  {result['domain']}")

    if errors:
        print(f"\n ERRORS ({len(errors)}):")
        print("-" * 40)
        for result in errors:
            print(f"  {result['domain']}: {result['error']}")

    print("\n" + "=" * 60)
    print(f"Total: {len(available)} available, {len(taken)} taken, "
          f"{len(unknown)} unknown, {len(errors)} errors")
    print("=" * 60)


if __name__ == "__main__":
    main()
