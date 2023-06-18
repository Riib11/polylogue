import Chat from "../Chat";

export default class <innerMessage, outerMessage> extends Chat<outerMessage> {
  readonly agent: Chat<innerMessage>
  readonly to: (outerMessage: outerMessage) => innerMessage
  readonly from: (innerMessage: innerMessage) => outerMessage

  constructor(
    agent: Chat<innerMessage>,
    to: (outerMessage: outerMessage) => innerMessage,
    from: (innerMessage: innerMessage) => outerMessage
  ) {
    super()
    this.agent = agent
    this.to = to
    this.from = from
  }

  async chat(messages: outerMessage[]): Promise<outerMessage> {
    const reply = await this.agent.chat(messages.map(this.to))
    return this.from(reply)
  }
}
