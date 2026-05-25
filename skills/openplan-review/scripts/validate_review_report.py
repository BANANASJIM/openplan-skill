#!/usr/bin/env python3
import re
import sys
from pathlib import Path


def fail(msg: str) -> int:
    print(f"INVALID: {msg}", file=sys.stderr)
    return 1


def main() -> int:
    if len(sys.argv) != 2:
        return fail("usage: validate_review_report.py <report.md>")

    path = Path(sys.argv[1])
    if not path.is_file():
        return fail(f"not a file: {path}")

    text = path.read_text(encoding="utf-8")
    if "BLOCKED:" in text:
        required = ["Missing artifact", "Why it matters", "Next safe step"]
        missing = [h for h in required if re.search(rf"^##?\s+{re.escape(h)}\b", text, re.M) is None and h not in text]
        if missing:
            return fail("blocked report missing sections: " + ", ".join(missing))
        print("VALID")
        return 0

    has_no_findings = re.search(r"\bNo blocking findings\b|\bNo findings\b", text, re.I) is not None
    has_findings = re.search(r"^##\s+Findings\b", text, re.M) is not None
    if not has_no_findings and not has_findings:
        return fail("report must include Findings or explicit no-findings statement")

    if has_findings:
        if re.search(r"^###\s+P[0-3]:", text, re.M) is None:
            return fail("findings must use severity headings like '### P1: title'")
        for field in ["Evidence:", "Invariant:", "Impact:", "Recommendation:", "Confidence:"]:
            if field not in text:
                return fail(f"finding missing field: {field}")

    if re.search(r"^##\s+Tests / Checks Run\b", text, re.M) is None:
        return fail("missing 'Tests / Checks Run' section")
    if re.search(r"^##\s+Residual Risk\b", text, re.M) is None:
        return fail("missing 'Residual Risk' section")
    if re.search(r"\bapproved\b|\bLGTM\b", text, re.I):
        return fail("avoid approval language; report reviewed scope and findings only")

    print("VALID")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
