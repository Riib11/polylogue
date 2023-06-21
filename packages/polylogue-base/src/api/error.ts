export class EmptyResultsError extends Error {
  constructor(request: any) {
    super("Expected at least one choice in response to request:\n\n" + JSON.stringify(request))
  }
}
