import Agent from "../Agent"

export default abstract class <message> extends Agent {
  abstract chat(messages: message[]): Promise<message>
}

export class EmptyHistoryError extends Error {
  constructor() {
    super("Expected a non-empty history.")
  }
}
