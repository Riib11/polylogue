import Agent from "../Agent";

export default abstract class <message> extends Agent {
  abstract chat(history: message[]): Promise<message>;
}

export class EmptyHistoryError extends Error {
  constructor() {
    super("Expected a non-empty history.");
  }
}
