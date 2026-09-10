import assert from "node:assert/strict";
import test from "node:test";

import { parseConfig, type AppConfig } from "../src/config.ts";

test("accepts a valid configuration", () => {
  const input: AppConfig = { mode: "fast", retryLimit: 7 };

  const actual = parseConfig(input);

  assert.deepEqual(actual, input);
});

test("rejects a non-object configuration", () => {
  const input = null;

  const act = () => parseConfig(input);

  assert.throws(act, /^TypeError: Invalid configuration:/);
});

test("rejects a configuration with a missing field", () => {
  const input = { mode: "safe" };

  const act = () => parseConfig(input);

  assert.throws(act, /^TypeError: Invalid configuration:/);
});

test("rejects an unsupported mode", () => {
  const input = { mode: "turbo", retryLimit: 3 };

  const act = () => parseConfig(input);

  assert.throws(act, /^TypeError: Invalid configuration:/);
});

test("rejects a fractional retry limit", () => {
  const input = { mode: "safe", retryLimit: 1.5 };

  const act = () => parseConfig(input);

  assert.throws(act, /^TypeError: Invalid configuration:/);
});

test("rejects a negative retry limit", () => {
  const input = { mode: "safe", retryLimit: -1 };

  const act = () => parseConfig(input);

  assert.throws(act, /^TypeError: Invalid configuration:/);
});
