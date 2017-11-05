import { shallow } from 'vue-test-utils'
import Counter from '../components/counter.vue'

describe('counter.vue', () => {
  it('increments count when button is clicked', () => {
    const wrapper = shallow(Counter)
    wrapper.find('button').trigger('click')
    expect(wrapper.find('div').text()).toMatch('1')
  })
})