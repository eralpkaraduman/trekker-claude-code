import { execFile } from 'node:child_process';
import { promisify } from 'node:util';
import type { CliRunnerOptions, TrekkerResult } from './types.js';

const execFileAsync = promisify(execFile);

export async function runTrekker<T = unknown>(
  args: string[],
  options: CliRunnerOptions = {}
): Promise<TrekkerResult<T>> {
  const { cwd = process.cwd(), json = true, toon = false } = options;

  const fullArgs: string[] = [];
  if (json) fullArgs.push('--json');
  if (toon) fullArgs.push('--toon');
  fullArgs.push(...args);

  try {
    const { stdout, stderr } = await execFileAsync('trekker', fullArgs, {
      cwd,
      timeout: 30000,
    });

    if (stderr && !json) {
      console.error('trekker stderr:', stderr);
    }

    if (json && stdout.trim()) {
      try {
        const data = JSON.parse(stdout) as T;
        return { success: true, data };
      } catch {
        return { success: true, data: stdout as unknown as T };
      }
    }

    return { success: true, data: stdout as unknown as T };
  } catch (error) {
    const err = error as Error & { stderr?: string; code?: string };
    return {
      success: false,
      error: err.stderr || err.message || 'Unknown error',
    };
  }
}

export async function runTrekkerText(
  args: string[],
  options: Omit<CliRunnerOptions, 'json'> = {}
): Promise<TrekkerResult<string>> {
  return runTrekker<string>(args, { ...options, json: false });
}
