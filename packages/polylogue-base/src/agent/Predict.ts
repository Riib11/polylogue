import Agent from "../Agent"

export default abstract class extends Agent {
  abstract predict(prompt: string): Promise<string>
}
