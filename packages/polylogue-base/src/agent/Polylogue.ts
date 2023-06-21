import Agent from "../Agent";
import { ChatMessage } from "../api/universal";
import Chat from "./Chat";

export type Interlocutors<name extends string> = { [n in name]: Chat }

export default abstract class <name extends string> extends Agent {
  interlocutors: Interlocutors<name>

  constructor(interlocutors: Interlocutors<name>) {
    super()
    this.interlocutors = interlocutors
  }

  abstract transition(source: name, messages: ChatMessage[]): Promise<{ target: name, messages: ChatMessage[] } | undefined>

  async chatTo(name: name, inputMessages: ChatMessage[]) {
    const outputMessage = await this.interlocutors[name].chatArray(inputMessages)
    const trans = await this.transition(name, [outputMessage])
    if (trans === undefined) return
    await this.chatTo(trans.target, trans.messages)
  }
}