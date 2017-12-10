// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


import Vue from 'vue/dist/vue.esm'
import BootstrapVue from 'bootstrap-vue'
import ApplyStatusSelect from './components/apply-status-select.vue'
import ChangeBalance from './components/change-balance.vue'

Vue.use(BootstrapVue)
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#customer-main',
    data: {
      message: "Can you say hello?",
    },
    components: {
      ApplyStatusSelect,
      ChangeBalance
    }
  })
})
