<template>
  <table class="table table-bordered table-hover">
    <tbody>
      <tr>
        <th class="w5p">&nbsp;</th>
        <th class="w20p">日付</th>
        <th class="w20p">申請額</th>
        <th class="w20p">承認額</th>
        <th class="w20p">支払額</th>
        <th class="">&nbsp;</th>
      </tr>
      <template v-for="(col, index) in application_list">
        <tr :key="col.id" v-on:click="open_info(index)">
          <td class="text-center">
            <i class="fa"
               :class="{'fa-plus':collapsed[index], 'fa-minus':!collapsed[index]}"
               aria-hidden="true"></i>
          </td>
          <td>{{ col.date }}</td>
          <td>{{ col.applied_amount }}円</td>
          <td>{{ col.approved_amount }}円</td>
          <td>{{ col.payed_amount }}円</td>
          <td class="text-center">
            <span class="input-group">
              <input type="checkbox" aria-label="...">
            </span>
          </td>
        </tr>
        <tr v-show="!collapsed[index]">
          <td>&nbsp;</td>
          <td>
            申請日時
          </td>
          <td>
            申請者
          </td>
          <td>
            所属
          </td>
          <td>
            申請額
          </td>
          <td>
            承認欄
          </td>
        </tr>
        <template v-for="(col, index) in application_list" v-if="!collapsed[index]">
          <tr>
            <td>&nbsp;</td>
            <td>
              2017/10/02/15:05
            </td>
            <td>
              佐藤 二郎
            </td>
            <td>
              新宿
            </td>
            <td>
              10,000
            </td>
            <td>
              可
            </td>
          </tr>
        </template>
      </template>
    </tbody>
  </table>
</template>

<script>
  export default {
    components: {
    },
    props: [
      'applicationList',
    ],
    data: function () {
      const application_list = JSON.parse(this.applicationList)
      return {
        collapsed: new Array(application_list.length).fill(true),
        application_list: application_list,
      }
    },
    created: function () {
    },
    methods: {
      open_info: function(index) {
        let vm = this
        vm.$set(vm.collapsed, index, !vm.collapsed[index])
      },
    }
  }
</script>

<style scoped>
</style>
