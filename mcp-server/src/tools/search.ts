import type { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import * as z from 'zod';
import { runTrekker } from '../cli-runner.js';

export function registerSearchTools(server: McpServer): void {
  server.registerTool(
    'trekker_semantic_search',
    {
      title: 'Semantic Search',
      description: 'Search tasks and epics by meaning using AI embeddings',
      inputSchema: {
        query: z.string().describe('Natural language query'),
        type: z.string().optional().describe('Filter by type: epic,task,subtask,comment (comma-separated)'),
        status: z.string().optional().describe('Filter by status'),
        threshold: z.number().min(0).max(1).optional().describe('Similarity threshold 0-1 (default: 0.5)'),
        limit: z.number().optional().describe('Max results (default: 20)'),
      },
    },
    async ({ query, type, status, threshold, limit }) => {
      const args = ['semantic-search', query];
      if (type) args.push('--type', type);
      if (status) args.push('--status', status);
      if (threshold !== undefined) args.push('--threshold', String(threshold));
      if (limit !== undefined) args.push('--limit', String(limit));

      const result = await runTrekker(args);
      return {
        content: [{ type: 'text', text: JSON.stringify(result, null, 2) }],
      };
    }
  );

  server.registerTool(
    'trekker_find_similar',
    {
      title: 'Find Similar',
      description: 'Find similar tasks to detect duplicates',
      inputSchema: {
        idOrText: z.string().describe('Task ID (TREK-n, EPIC-n) or text to search for'),
        threshold: z.number().min(0).max(1).optional().describe('Similarity threshold 0-1 (default: 0.7)'),
        limit: z.number().optional().describe('Max results (default: 10)'),
      },
    },
    async ({ idOrText, threshold, limit }) => {
      const args = ['similar', idOrText];
      if (threshold !== undefined) args.push('--threshold', String(threshold));
      if (limit !== undefined) args.push('--limit', String(limit));

      const result = await runTrekker(args);
      return {
        content: [{ type: 'text', text: JSON.stringify(result, null, 2) }],
      };
    }
  );

  server.registerTool(
    'trekker_hybrid_search',
    {
      title: 'Hybrid Search',
      description: 'Search using combined keyword and semantic matching',
      inputSchema: {
        query: z.string().describe('Search query'),
        type: z.string().optional().describe('Filter by type: epic,task,subtask,comment (comma-separated)'),
        status: z.string().optional().describe('Filter by status'),
        limit: z.number().optional().describe('Max results (default: 20)'),
      },
    },
    async ({ query, type, status, limit }) => {
      const args = ['search', query, '--mode', 'hybrid'];
      if (type) args.push('--type', type);
      if (status) args.push('--status', status);
      if (limit !== undefined) args.push('--limit', String(limit));

      const result = await runTrekker(args);
      return {
        content: [{ type: 'text', text: JSON.stringify(result, null, 2) }],
      };
    }
  );
}
