export class EmptyChoicesInResponse extends Error {
  constructor() {
    super("Expected at least one choice in response.")
  }
}
