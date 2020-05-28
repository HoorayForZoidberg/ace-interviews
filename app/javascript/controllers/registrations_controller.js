import { Controller } from 'stimulus'
import { initSelect2 } from './../packs/components/init_select2'

export default class extends Controller {
  static targets = ["select2"]
  connect(){
    initSelect2(this.select2Target, { width: "100%"})
  }
}
