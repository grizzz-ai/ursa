export type AppConfig = {
  mode: "safe" | "fast";
  retryLimit: number;
};

const DEFAULT_CONFIG: AppConfig = {
  mode: "safe",
  retryLimit: 3,
};

function isAppConfig(value: unknown): value is AppConfig {
  if (typeof value !== "object" || value === null) {
    return false;
  }

  const candidate = value as Record<string, unknown>;
  const validMode = candidate.mode === "safe" || candidate.mode === "fast";
  const validRetryLimit = Number.isInteger(candidate.retryLimit) && Number(candidate.retryLimit) >= 0;
  return validMode && validRetryLimit;
}

export function parseConfig(value: unknown): AppConfig {
  if (!isAppConfig(value)) {
    return { ...DEFAULT_CONFIG };
  }

  return value;
}
