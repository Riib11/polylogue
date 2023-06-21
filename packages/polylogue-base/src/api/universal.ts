// =============================================================================
// universal interfaces for various APIs
// =============================================================================

import * as OpenAi from './openai'
import * as GoogleVertex from './google-vertex'

// =============================================================================
// ChatMessage
// =============================================================================

export type ChatMessage = { type: ChatMessageType, content: string }
export type ChatMessageType = 'client' | 'server'

// A translation with inner `message` and outer `ChatMessage`.
export type ChatMessageTranslation<message> = {
  to: (msg: ChatMessage) => message,
  from: (msg: message) => ChatMessage,
}

// function makeChatMessageTranslation<message, typeKey extends keyof message, contentKey extends keyof message>(
function makeChatMessageTranslation<message, messageType>(
  makeMessage: (type: messageType, content: string) => message,
  getMessageType: (msg: message) => messageType,
  getMessageContent: (msg: message) => string,
  pairs: [messageType, ChatMessageType][]
): ChatMessageTranslation<message> {
  return ({
    to: msg => {
      const pair = pairs.find(pair => pair[1] == msg.type)
      return makeMessage(pair[0], msg.content)
    },
    from: msg => {
      const pair = pairs.find(pair => pair[0] == getMessageType(msg))
      return { type: pair[1], content: getMessageContent(msg) }
    }
  })
}

export const openAiChatMessageTranslation: ChatMessageTranslation<OpenAi.ChatMessage> =
  makeChatMessageTranslation<OpenAi.ChatMessage, OpenAi.ChatRole>(
    (role, content) => ({ role, content }), msg => msg.role, msg => msg.content,
    [
      ['assistant', 'server'],
      ['system', 'client'],
      ['user', 'client']
    ]
  )

export const googleVertexChatMessageTranslation: ChatMessageTranslation<GoogleVertex.ChatMessage> =
  makeChatMessageTranslation<GoogleVertex.ChatMessage, GoogleVertex.ChatAuthor>(
    (author, content) => ({ author, content }), msg => msg.author, msg => msg.content,
    [
      ['0', 'client'],
      ['user', 'client'],
      ['1', 'server'],
      ['bot', 'server'],
    ]
  )
