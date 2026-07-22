import { loadQuartzConfig, loadQuartzLayout } from "./quartz/plugins/loader/config-loader"
import * as ExternalPlugin from "./.quartz/plugins"

type ExplorerNode = {
  slug?: string
  displayName: string
  isFolder: boolean
  data?: {
    slug?: string
  } | null
}

ExternalPlugin.Explorer({
  mapFn: (node: ExplorerNode) => {
    const displayNames: Record<string, string> = {
      knowledge: "지식 문서",
      "knowledge/problem": "문제 이해",
      "knowledge/landscape": "시장과 경쟁 구도",
      "knowledge/technology": "기술 접근",
      "knowledge/synthesis": "제품 종합",
      sources: "Source Summaries",
      log: "Wiki Log",
      "open-questions": "미결 질문",
    }
    const rawSlug = String(node.slug ?? node.data?.slug ?? "")
    const slug = rawSlug.endsWith("/index") ? rawSlug.slice(0, -"/index".length) : rawSlug
    const displayName = displayNames[slug]
    if (displayName) {
      node.displayName = displayName
    }
  },
  sortFn: (a: ExplorerNode, b: ExplorerNode) => {
    const explicitOrder: Record<string, number> = {
      index: 0,
      overview: 10,
      "open-questions": 20,
      log: 30,
      knowledge: 40,
      sources: 50,
      "knowledge/problem": 100,
      "knowledge/problem/behavioral-data-practitioners": 110,
      "knowledge/problem/buyer-and-champion": 120,
      "knowledge/problem/tracking-qa-workflow": 130,
      "knowledge/landscape": 200,
      "knowledge/landscape/behavioral-data-quality-landscape": 210,
      "knowledge/landscape/tracking-governance-platforms": 220,
      "knowledge/landscape/avo": 230,
      "knowledge/landscape/amplitude-data": 240,
      "knowledge/landscape/tag-audit-and-qa-tools": 250,
      "knowledge/landscape/autocapture-and-tag-manager-layer": 260,
      "knowledge/landscape/pricing-and-packaging": 270,
      "knowledge/technology": 300,
      "knowledge/technology/collection-and-validation-patterns": 310,
      "knowledge/technology/key-terms": 320,
      "knowledge/technology/validation-layer-model": 330,
      "knowledge/technology/schema-and-data-contracts": 340,
      "knowledge/technology/codegen-and-tracking-plan-workflow": 350,
      "knowledge/technology/element-event-evidence": 360,
      "knowledge/technology/autonomous-traversal-evaluation": 370,
      "knowledge/synthesis": 400,
      "knowledge/synthesis/automation-opportunity": 410,
      "knowledge/synthesis/mvp-outcome-options": 420,
      "knowledge/synthesis/research-confidence-map": 430,
      "sources/source-practitioner-pain-points": 510,
      "sources/source-autocapture-tag-managers": 520,
      "sources/source-tag-audit-qa-tools": 530,
      "sources/source-avo": 540,
      "sources/source-avo-official-data-design": 550,
      "sources/source-amplitude-data-ampli": 560,
      "sources/source-amplitude-official-data-governance": 570,
      "sources/source-tracking-governance-four-tools": 580,
      "sources/source-tracking-governance-remaining-tools": 590,
      "sources/source-segment-protocols-official": 600,
      "sources/source-mparticle-data-planning-official": 610,
      "sources/source-rudderstack-tracking-plans-official": 620,
      "sources/source-schema-data-contracts": 630,
      "sources/source-snowplow-dbt-data-quality-official": 640,
      "sources/source-web-agent-eval-benchmarks": 650,
    }
    const getSlug = (node: ExplorerNode) => {
      const slug = String(node.slug ?? node.data?.slug ?? "")
      return slug.endsWith("/index") ? slug.slice(0, -"/index".length) : slug
    }
    const rankDifference =
      (explicitOrder[getSlug(a)] ?? Number.MAX_SAFE_INTEGER) -
      (explicitOrder[getSlug(b)] ?? Number.MAX_SAFE_INTEGER)
    if (rankDifference !== 0) {
      return rankDifference
    }

    if (a.isFolder !== b.isFolder) {
      return a.isFolder ? -1 : 1
    }

    return a.displayName.localeCompare(b.displayName, "ko-KR", {
      numeric: true,
      sensitivity: "base",
    })
  },
  order: ["map", "sort"],
})

const config = await loadQuartzConfig()
export default config
export const layout = await loadQuartzLayout()
