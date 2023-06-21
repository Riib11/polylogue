import { ChatMessage } from "../../api/universal";
import Polylogue, { Interlocutors } from "../Polylogue";

export default class <name extends string> extends Polylogue<name>{
  _transition: (source: name, messages: ChatMessage[]) => Promise<{ target: name, messages: ChatMessage[] } | undefined>

  constructor(interlocutors: Interlocutors<name>, _transition: (source: name, messages: ChatMessage[]) => Promise<{ target: name, messages: ChatMessage[] } | undefined>) {
    super(interlocutors)
    this._transition = _transition
  }

  transition(source: name, messages: ChatMessage[]): Promise<{ target: name, messages: ChatMessage[] } | undefined> {
    return this._transition(source, messages)
  }
}