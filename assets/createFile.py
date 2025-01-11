'''
Python Script to generate the random quotes used when an internet connection is unavailable.
'''

import requests
import json
import argparse
import os

# Constants
# Replace with your preferred API if needed
API_URL = "https://qapi.vercel.app/api/random"
DEFAULT_QUOTE_COUNT = 10
OUTPUT_FILE = "quotes.json"


def fetch_quote():
    """Fetch a single quote from the API."""
    try:
        response = requests.get(API_URL)
        response.raise_for_status()
        data = response.json()
        return {"quote": data.get('quote')}
    except requests.RequestException as e:
        print(f"Error fetching quote: {e}")
        return {"quote": "Failed to fetch quote."}


def generate_quotes(count):
    """Generate a list of quotes."""
    quotes = []
    print(f"Fetching {count} quotes...")
    for i in range(count):
        quote = fetch_quote()
        quotes.append(quote)
        print(f"{i + 1}: {quote['quote']}")
    return quotes


def save_to_file(quotes, output_file):
    """Save quotes to a JSON file."""
    try:
        with open(output_file, "w", encoding="utf-8") as file:
            json.dump(quotes, file, ensure_ascii=False, indent=2)
        print(f"Quotes saved to {output_file}.")
    except IOError as e:
        print(f"Error saving quotes to file: {e}")


def main():
    """Main function to handle script execution."""
    parser = argparse.ArgumentParser(
        description="Generate a JSON file with random inspirational quotes.")
    parser.add_argument(
        "-c", "--count", type=int, default=DEFAULT_QUOTE_COUNT,
        help="Number of quotes to fetch (default: 10)"
    )
    parser.add_argument(
        "-o", "--output", type=str, default=OUTPUT_FILE,
        help="Output JSON file (default: quotes.json)"
    )
    args = parser.parse_args()

    # Generate quotes
    quotes = generate_quotes(args.count)

    # Save to file
    save_to_file(quotes, args.output)


if __name__ == "__main__":
    main()
