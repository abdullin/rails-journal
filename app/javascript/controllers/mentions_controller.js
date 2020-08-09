
import { Controller } from "stimulus"
import Trix from "trix"
import Tribute from "tributejs"


export default class extends Controller {
  static targets = [ "field" ]

  connect() {
    this.editor = this.fieldTarget.editor
    this.initTribute()
  }

  initTribute(){
    this.tribute = new Tribute({
      allowSpaces: true,
      lookup: "name",
      values: this.fetchMentions,
      replaceTextSuffix: '',
      selectTemplate: function(item) { return '' },
    })

    this.tribute.attach(this.fieldTarget)
    this.tribute.range.pasteHtml = function(){}
    this.fieldTarget.addEventListener("tribute-replaced", this.replaced)
    this.fieldTarget.addEventListener("keydown", this.keydown)
  }

  keydown(e) {
    if (e.key == '@') {
      this.startPos = this.editor.getPosition()
      console.log("started tracking", this.startPos)
    }
  }

  disconnect(){
    this.tribute.detach(this.fieldTarget)
  }


  fetchMentions(query, callback) {
    fetch(`/mentions.json?query=${query}`)
    .then(resp => resp.json())
    .then(mentions => callback(mentions))
    .catch(err => callback([]))
  }

  replaced(e) {
    let position = this.editor.getPosition()
    this.editor.setSelectedRange([this.startPos, position])
    this.editor.deleteInDirection("backward")

    let mention = e.detail.item.original
    let attachment = new Trix.Attachment({
      sgid: mention.sgid,
      content: mention.content
    })
    this.editor.insertAttachment(attachment)
    this.editor.insertString(" ")
  }
}
