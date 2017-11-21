import { mount } from 'vue-test-utils'
import MemberAccordion from '../components/member-accordion.vue'

describe('member-accordion.vue', () => {
  it('click plus sign open up the row', () => {
    const memberList = [
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
    const wrapper = mount(MemberAccordion, {
      propsData: {
        memberList: JSON.stringify(memberList)
      }
    })
    wrapper.find('i.fa').trigger('click')
    expect(wrapper.find('div.accordion').text()).toMatch('入社年月日')
  })
})
