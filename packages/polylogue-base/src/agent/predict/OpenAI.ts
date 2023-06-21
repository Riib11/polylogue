import { ChatMessage } from "../../api/universal"
import Predict from "../Predict"
import ChatOpenAI, { Config } from "../chat/OpenAI"

export default class extends Predict {
  private readonly chatAgent: ChatOpenAI

  constructor(config: Config) {
    super()
    this.chatAgent = new ChatOpenAI(config)
  }

  async predict(prompt: string): Promise<string> {
    const msg: ChatMessage = { type: 'client', content: prompt }
    return (await this.chatAgent.chatArray([msg])).content
  }
}