// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


import Vue from 'vue/dist/vue.esm'
import MemberAccordion from './components/member-accordion.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#customer-main',
    data: {
      message: "Can you say hello?"
    },
    components: { MemberAccordion }
  })
})
