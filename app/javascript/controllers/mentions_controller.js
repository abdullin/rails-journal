import { Controller } from "stimulus"
import Trix from "trix"
import Tribute from "tributejs"

// Extends trix editor to support user mentions that start with "@"
// Enable it like this:
// <%= form.rich_text_area :content, data: { controller: "mentions", target:"mentions.field"} %>
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
    // we insert out attachment
    this.tribute.range.pasteHtml = function(){}
    this.fieldTarget.addEventListener("tribute-replaced", this.replaced)
    this.fieldTarget.addEventListener("keydown", this.record_position)
  }


  disconnect(){
    this.tribute.detach(this.fieldTarget)
  }

  record_position(e) {
    if (e.key == '@') {
      this.startPos = this.editor.getPosition()
    }
  }

  fetchMentions(query, callback) {
    fetch(`/mentions.json?query=${query}`)
    .then(resp => resp.json())
    .then(mentions => callback(mentions))
    .catch(err => callback([]))
  }


  replaced(e) {
    // delete typed characted
    let position = this.editor.getPosition()
    this.editor.setSelectedRange([this.startPos, position])
    this.editor.deleteInDirection("backward")

    // insert mention
    let mention = e.detail.item.original
    let attachment = new Trix.Attachment({
      sgid: mention.sgid,
      content: mention.content
    })
    this.editor.insertAttachment(attachment)
    this.editor.insertString(" ")
  }
}
