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
            <th scope="col" class="w150">日付</th>
            <th scope="col">出勤</th>
            <th scope="col">退勤</th>
            <th scope="col">給与</th>
            <th scope="col">　</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="working_record in working_records" :key="working_record.id">
            <td>{{ working_record.start_date }}</td>
            <td>{{ working_record.start_time }}</td>
            <td>{{ working_record.finish_time }}</td>
            <td>{{ working_record.payment }}円(時給{{ working_record.hourly_pay }}円)</td>
            <td>
              <button @click.prevent.self="working_record_edit_open(worker, working_record)" class="btn btn-info">修正</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <bootstrap-modal ref="working_record_edit"
                     :need-header="true"
                     :need-footer="false"
                     :size="'large'">
      <div slot="title">
        {{ modal_worker.name }}さんの{{modal_data.record_date}}の記録を修正する
      </div>
      <div slot="body">
        <div class="content" ref="workingRecord">
          <div class="form-group row">
            <label for="example-text-input" class="col-md-2 col-form-label mt5">開始時刻</label>
            <div class="col-md-10">
              <vue-timepicker :minute-interval='1' v-model="modal_data.start_time"></vue-timepicker>
            </div>
          </div>
          <div class="form-group row">
            <label for="example-text-input" class="col-md-2 col-form-label mt5">終了時刻</label>
            <div class="col-md-10">
              <vue-timepicker :minute-interval='1' v-model="modal_data.finish_time"></vue-timepicker>
            </div>
          </div>
          <div class="form-group row">
            <button type="submit" class="btn btn-warning col-md-4 col-md-offset-4" @click="update_working_record">送信</button>
          </div>
        </div>
      </div>
      <div slot="footer">
      </div>
    </bootstrap-modal>
  </div>
</template>

<script>
  import axios from 'axios'
  import bootstrapModal from 'vue2-bootstrap-modal'
  import VueTimepicker from 'vue2-timepicker'
  var tokens = document.getElementsByName('csrf-token')
  if (tokens.length) {
    axios.defaults.headers['X-CSRF-Token'] = tokens.item(0).content
  }

  export default {
    template: '...',
    components: {
      bootstrapModal,
      VueTimepicker
    },
    props: [
      'workingRecords',
      'worker'
    ],
    data: function () {
      return {
        current_month: (new Date()),
        month_diff: 0,
        working_records: this.workingRecords,
        worker_id: this.worker.id,
        modal_worker: {
          name: '',
        },
        modal_data: {
          id: '',
          title: '',
          record_date: '',
          start_time: {
            'HH': '',
            'mm': ''
          },
          finish_time: {
            'HH': '',
            'mm': ''
          },
        },
        token: axios.defaults.headers['X-CSRF-Token']
      }
    },
    watch: {
      workingRecords: function (val) {
        this.working_records = val
      },
      worker: function (val) {
        this.worker_id = val.id
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
      update_working_record() {
        var vm = this
        axios
          .put('/api/customer/worker_record/' + vm.worker_id,
               { 'worker_record': {'record_date': vm.modal_data.record_date,
                                   'finish_time': vm.modal_data.finish_time,
                                   'start_time' : vm.modal_data.start_time,
                                   'id'         : vm.modal_data.id
                                  }
               }).then(({data, _status}) => {
                 var vm_data = vm.working_records.find((e)=> { return e.id === vm.modal_data.id})
                 vm.$set(vm_data, 'start_time',
                         vm.modal_data.start_time['HH'] + ':' + vm.modal_data.start_time['mm'])
                 vm.$set(vm_data, 'finish_time',
                         vm.modal_data.finish_time['HH'] + ':' + vm.modal_data.finish_time['mm'])
                 vm.$set(vm_data, 'payment', data.payment)

                 this.$refs.working_record_edit.close()
                 alert(data.message)
               },({error, response}) => {
                 alert(response.data.message)
               }).catch(() => {})
      },
      working_record_edit_open: function(current_worker, working_record) {
        var vm = this
        vm.modal_worker = current_worker
        vm.$set(vm.modal_data, 'record_date', working_record.start_date)

        let start_time = working_record.start_time.split(':')
        let finish_time = working_record.finish_time.split(':')

        vm.$set(vm.modal_data, 'id', working_record.id)
        vm.$set(vm.modal_data, 'start_time', {'HH': start_time[0], 'mm': start_time[1]})
        vm.$set(vm.modal_data, 'finish_time', {'HH': finish_time[0], 'mm': finish_time[1]})

        this.$refs.working_record_edit.open()
      }
    }
  }
</script>

<style scoped>
</style>

