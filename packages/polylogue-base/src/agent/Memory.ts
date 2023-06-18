import Agent from "../Agent"

export default abstract class <message> extends Agent {
  abstract insert(message: message): Promise<void>
  abstract getMemoryArray(): Promise<message[]>
}

