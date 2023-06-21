import { ChatMessage } from "../../api/openai"
import Predict from "../Predict"
import ChatOpenAI, { Config } from "../chat/OpenAI"

export default class extends Predict {
  private readonly chatAgent: ChatOpenAI

  constructor(config: Config) {
    super()
    this.chatAgent = new ChatOpenAI(config)
  }

  async predict(prompt: string): Promise<string> {
    const msg: ChatMessage = {role: 'user', content: prompt}
    return (await this.chatAgent.chat([msg])).content
  }
}