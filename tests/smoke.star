# tests/smoke.star — stable across upstream bun releases.
BUN = "bun.exe" if ocx.target_platform.os == ocx.os.Windows else "bun"

# Tier 1 + 2: liveness on the composed PATH + semver version shape.
r = ocx.run(BUN, "--version")
expect.ok(r)
expect.matches(r.stdout, r"\d+\.\d+\.\d+")

# Tier 3: functional behavior on hermetic input — assert the computed result.
r = ocx.run(BUN, "-e", "console.log(40 + 2)")
expect.ok(r)
expect.contains(r.stdout, "42")

ocx.write_file("hello.js", "console.log(JSON.stringify({ok: true, n: 7}))\n")
r = ocx.run(BUN, "hello.js")
expect.ok(r)
expect.contains(r.stdout, "\"ok\":true")
