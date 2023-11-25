import { getArticles } from "../../../src/core/articles/services/ArticlesService";

describe("ArticlesService", () => {
  it("should be false", () => {
    expect(false).toBe(false);
  });

  it("getArticles should not be equal to false", async () => {
    expect(await getArticles).not.toEqual(false);
  });
});
