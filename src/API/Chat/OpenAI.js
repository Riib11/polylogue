import { Configuration, OpenAIApi } from "openai";

// make an OpenAIApi instance
export const _makeClient = (config) => () =>
  new OpenAIApi(new Configuration(config))

const DEBUG = true

// makes a chat request
export const _createChatCompletion = openai => chatCompletionRequest => {
  return async (onError, onSuccess) => {
    let response = await openai.createChatCompletion(chatCompletionRequest)
    if (response === undefined) onError("chat: response was undefined")
    let data = response.data
    if (DEBUG) console.log("response.data", data)
    onSuccess(data)
    return (cancelError, onCancelerError, onCancelerSuccess) => onCancelerSuccess(x)
  }
}
