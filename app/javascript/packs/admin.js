// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


import Vue from 'vue/dist/vue.esm'
import WorkerAccordion from './components/worker-accordion.vue'
import ApplicationRecord from './components/application-record.vue'
import 'chart.js'
import 'hchs-vue-charts'

document.addEventListener('DOMContentLoaded', () => {
  Vue.use(window.VueCharts)
  const app = new Vue({
    el: '#customer-main',
    data: {
      message: "Can you say hello?",
    },
    components: {
      WorkerAccordion,
      ApplicationRecord,
    }
  })
})
