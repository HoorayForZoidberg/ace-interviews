import { Controller } from 'stimulus'
import { initSelect2 } from './../packs/components/init_select2'

export default class extends Controller {
  static targets = ["select2"]
  connect(){
    initSelect2(this.select2Target, {
      width: '100%',
      minimumInputLength: 3,
      language: {
        inputTooShort: function () {
          return "Searching...";
        }
      },
      ajax: {
        url: '/universities',
        dataType: 'json',
        type: 'GET',
        data: function(params) {
          var query = {
            search: params.term
          }
          return query
        },
        processResults: function(data) {
          return {
            results: data
          }
        }
      }
    })
  }
}
