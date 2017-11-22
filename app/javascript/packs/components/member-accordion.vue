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
        <tr :key="col.id" v-on:click="open_worker_info(index, col.id)">
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
            <member-basic-info :member='current_worker'></member-basic-info>
            <div class="clearfix mt20 p10">
              <button type="button" class="btn btn-secondary col-md-4 col-md-offset-1">前払金ログ</button>
              <button type="button" class="btn btn-primary col-md-4 col-md-offset-2">出席ログ</button>
            </div>
            <div class='accordion p10'>
              <h3 class="bg-white text-center w280 m-center lh50 mt20 mb10">
                <span class="c-p mr10" v-on:click="update_date(-1)">◀</span>
                {{date}}
                <span class="c-p ml10" v-on:click="update_date(1)">▶</span>
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
                    <tr v-for="row in working_records">
                      <td>{{ row.start_date }}</td>
                      <td>{{ row.start_time }}</td>
                      <td>{{ row.finish_time }}</td>
                      <td>未実装</td>
                      <td>未実装</td>
                      <td>未実装</td>
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
      const current_year = (new Date()).getFullYear();
      const current_month = (new Date()).getMonth() + 1;
      return {
        collapsed: new Array(member_list.length).fill(true),
        member_list: member_list,
        date: current_year + "年 " + current_month + "月",
        working_records: [],
        current_open_index: 0,
        current_worker: {
          uid: '',
          name: '',
          address: '',
          branch_name: '',
          emai: '',
          entrance_date: '',
          hourly_pay: '',
          birthday: '',
          bank_account: '',
        }
      }
    },
    created: function () {
    },
    methods: {
      open_worker_info: function(index, worker_id) {
        var vm = this
        axios
          .get('/api/customer/worker_record/' + worker_id)
          .then(({data, status}) => {
            console.debug("ooooook")
            if (vm.current_open_index !== 0) {
              vm.$set(vm.collapsed, vm.current_open_index, !vm.collapsed[vm.current_open_index])
            }
            vm.current_open_index = index
            vm.current_worker = data.worker
            vm.$set(vm.collapsed, index, !vm.collapsed[index])
            vm.working_records = data.working_records
          })
          .catch(() => {
            alert("connection error")
          })
      },
      update_worker_rows: function(month_diff) {
      },
      update_date: function(increment) {
        function compute_new_date(date, increment) {
          var values = date.split(' ')
          var year = parseInt(values[0].slice(0, -1), 10);
          var month = parseInt(values[1].slice(0, -1), 10);
  
          month += increment
          if (month > 12) {
            month = 1;
            year += 1;
          }
          if (month < 1) {
            month = 12;
            year -= 1;
          }
          return year + "年 " + month + "月"
        }

        this.date = compute_new_date(this.date, increment);
        this.update_worker_rows();
      },
    }
  }
</script>

<style scoped>
</style>
