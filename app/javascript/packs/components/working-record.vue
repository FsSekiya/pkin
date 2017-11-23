<template>
  <div class='accordion p10'>
    <h3 class="bg-white text-center w280 m-center lh50 mt20 mb10 row">
      <span class="c-p col-md-2" v-on:click="update_date(-1)">◀</span>
      <span class="col-md-8">{{current_month.getFullYear()}}年{{current_month.getMonth()+1}}月</span>
      <span class="c-p col-md-2" v-on:click="update_date(1)" v-if="!older_than_current_month()">▶</span>
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
</template>

<script>
  import axios from 'axios'
  export default {
    components: {
    },
    props: [
      'working_records'
    ],
    data: function () {
      return {
        current_month: (new Date())
      }
    },
    created: function () {
    },
    methods: {
      update_worker_rows: function(month_diff) {
      },
      update_date: function(increment) {
        var vm = this
        vm.current_month = new Date(vm.current_month.setMonth(vm.current_month.getMonth() + increment))
      },
      older_than_current_month: function() {
        let today = new Date()
        if (this.current_month < today.setMonth(today.getMonth() - 1)) {
          return false
        }
        return true
      }
    }
  }
</script>

<style scoped>
</style>

