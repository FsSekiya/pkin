<template>
  <table class="table table-striped table-hover">
    <tbody>
      <tr>
        <th class="w40">&nbsp;</th>
        <th class="w50">ID</th>
        <th class="w120">名前</th>
        <th class="w120">時給</th>
      </tr>
      <template v-for="(col, index) in member_list">
        <tr :key="col.id" v-on:click="collapsed.splice(index, 1, !collapsed[index])">
          <td>
            <i
              class="fa"
              v-bind:class="{'fa-plus':collapsed[index], 'fa-minus':!collapsed[index]}"
              aria-hidden="true"></i>
          </td>
          <td>{{ col.id }}</td>
          <td>{{ col.name }}</td>
          <td>{{ col.hourly_pay }}円</td>
        </tr>
        <tr v-show="!collapsed[index]" :key="col.id">
          <td colspan=4>
            <member-basic-info :member='col'></member-basic-info>
            <div class="clearfix mt20 p10">
              <button type="button" class="btn btn-secondary col-md-4 col-md-offset-1">前払金ログ</button>
              <button type="button" class="btn btn-primary col-md-4 col-md-offset-2">出席ログ</button>
            </div>
            <div class='accordion p10'>
              <h3 class="bg-white text-center w280 m-center lh50 mt20 mb10">
                <span class="c-p mr10">◀</span>
                2017年 10月
                <span class="c-p ml10">▶</span>
              </h3>
              <div>
                <table class="table table-bordered table-striped">
                  <thead>
                    <tr>
                      <th scope="col">日付</th>
                      <th scope="col">出勤</th>
                      <th scope="col">退勤</th>
                      <th scope="col">休憩</th>
                      <th scope="col">給与</th>
                      <th scope="col">編集</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>2017/10/10</td>
                      <td>17:00</td>
                      <td>23:00</td>
                      <td>1:00</td>
                      <td>¥5000</td>
                      <td>編集</td>
                    </tr>
                    <tr>
                      <td>2017/10/10</td>
                      <td>17:00</td>
                      <td>23:00</td>
                      <td>1:00</td>
                      <td>¥5000</td>
                      <td>編集</td>
                    </tr>
                    <tr>
                      <td>2017/10/10</td>
                      <td>17:00</td>
                      <td>23:00</td>
                      <td>1:00</td>
                      <td>¥5000</td>
                      <td>編集</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </td>
        </tr>
      </template>
    </tbody>
  </table>
</template>

<script>
  import axios from 'axios'
  import MemberBasicInfo from './member-basic-info.vue'
  var tokens = document.getElementsByName('csrf-token')
  if (tokens.length) {
    axios.defaults.headers['X-CSRF-Token'] = tokens.item(0).content
  }
  export default {
    components: {
      MemberBasicInfo,
    },
    props: [
      'memberList',
    ],
    data: function () {
      const member_list = JSON.parse(this.memberList)
      return {
        collapsed: new Array(member_list.length).fill(true),
        member_list: member_list
      }
    },
    created: function () {
    },
    methods: {
      sample: function() {
        axios
          .get('/api/customer/sample')
          .then(() => {
            alert("owata")
          })
          .catch(() => {
            alert("hazimatta")
          })
      }
    }
  }
</script>

<style scoped>
</style>
