import assert from "node:assert/strict";
import test from "node:test";

import { parseConfig, type AppConfig } from "../src/config.ts";

test("accepts a valid configuration", () => {
  const input: AppConfig = { mode: "fast", retryLimit: 7 };

  const actual = parseConfig(input);

  assert.deepEqual(actual, input);
});

test("shows malformed configuration silently receives defaults", () => {
  const input = null;

  const actual = parseConfig(input);

  assert.deepEqual(actual, { mode: "safe", retryLimit: 3 });
});

test("rejects malformed configuration", () => {
  const input = null;

  const act = () => parseConfig(input);

  assert.throws(act, /^TypeError: Invalid configuration:/);
});
