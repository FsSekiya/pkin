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
            <th scope="col">給与</th>
            <th scope="col">編集</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="working_record in working_records" :key="working_record.id">
            <td>{{ working_record.start_date }}</td>
            <td>{{ working_record.start_time }}</td>
            <td>{{ working_record.finish_time }}</td>
            <td>{{ working_record.payment }}円(時給{{ working_record.hourly_pay }}円)</td>
            <td>
              <button v-on:click="working_record_edit_open()">編集</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <bootstrap-modal ref="working_record_edit"
                     :need-header="true"
                     :need-footer="true"
                     :size="'large'">
      <div slot="title">
        Your title here
      </div>
      <div slot="body">
        Your body here
      </div>
      <div slot="footer">
        Your footer here
      </div>
    </bootstrap-modal>
  </div>
</template>

<script>
  export default {
    components: {
      'bootstrap-modal': require('vue2-bootstrap-modal')
    },
    props: [
      'workingRecords',
      'workerId'
    ],
    data: function () {
      return {
        current_month: (new Date()),
        month_diff: 0,
        working_records: this.workingRecords,
        worker_id: this.workerId
      }
    },
    watch: {
      workingRecords: function (val) {
        this.working_records = val
      },
      workerId: function (val) {
        this.worker_id = val
      }
    },
    created: function () {
    },
    methods: {
      update_date: function(increment) {
        var vm = this
        let diff = vm.month_diff + increment
        axios
          .get('/api/customer/worker_record/' + vm.worker_id + '?month_diff=' + diff)
          .then(({data, _status}) => {
            vm.working_records = data.working_records
            vm.current_month = new Date(vm.current_month.setMonth(vm.current_month.getMonth() + increment))
            vm.month_diff += increment
          })
          .catch(() => {
          })
      },
      older_than_current_month: function() {
        let today = new Date()
        if (this.current_month < today.setMonth(today.getMonth() - 1)) {
          return false
        }
        return true
      },
      working_record_edit_open: function() {
        this.$refs.working_record_edit.open()
      }
    }
  }
</script>

<style scoped>
</style>

