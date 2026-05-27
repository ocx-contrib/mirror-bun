r_version = ocx.run("bun", "--version")
expect.ok(r_version)
expect.eq(r_version.exit_code, 0)
expect.true(len(r_version.stdout) > 0)

r_eval = ocx.run("bun", "-e", "console.log(40 + 2)")
expect.eq(r_eval.exit_code, 0)
expect.contains(r_eval.stdout, "42")

ocx.write_file("hello.js", "console.log(JSON.stringify({ok: true, n: 7}))\n")
r_run = ocx.run("bun", "hello.js")
expect.eq(r_run.exit_code, 0)
expect.contains(r_run.stdout, "\"ok\":true")
