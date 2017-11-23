import { mount } from 'vue-test-utils'
import WorkerAccordion from '../components/worker-accordion.vue'

describe('worker-accordion.vue', () => {
  it('click plus sign open up the row', () => {
    const workerList = [
      {
        id: 1,
        name: '名前',
        department: '開発部',
        hourly_pay: 1000
      },
      {
        id: 2,
        name: '名前',
        department: '開発部',
        hourly_pay: 1000
      },
    ]
    const wrapper = mount(WorkerAccordion, {
      propsData: {
        workerList: JSON.stringify(workerList)
      }
    })
    wrapper.find('i.fa').trigger('click')
    expect(wrapper.find('div.accordion').text()).toMatch('日付')
  })
})
