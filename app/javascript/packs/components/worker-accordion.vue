<template>
  <table class="table table-striped table-hover">
    <tbody>
      <tr>
        <th class="w40">&nbsp;</th>
        <th class="w50">ID</th>
        <th class="w120">名前</th>
        <th class="w120">時給</th>
      </tr>
      <template v-for="(col, index) in worker_list">
        <tr :key="col.id" v-on:click="open_worker_info(index, col.id)">
          <td class="text-center">
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
          <td colspan="4">
            <worker-basic-info :worker='current_worker'></worker-basic-info>
            <div class="clearfix mt20 p10">
              <button type="button" v-on:click="show_payment_records" class="btn btn-secondary col-4 offset-1">前払金ログ</button>
              <button type="button" v-on:click="show_worker_records" class="btn btn-primary col-4 offset-2">出席ログ</button>
            </div>
            <span id="working_records_span" v-if="workerRecordsActive">
                <working-record :working-records='working_records'
                            :worker='current_worker'
                            ></working-record>
            </span>
            <span id="payment_records_span" v-if="paymentRecordsActive">
                <payment-record :payment-records='payment_records'
                            :worker='current_worker'
                            ></payment-record>
            </span>
          </td>
        </tr>
      </template>
    </tbody>
  </table>
</template>

<script>
  import axios from 'axios'
  import WorkerBasicInfo from './worker-basic-info.vue'
  import WorkingRecord from './working-record.vue'
  import PaymentRecord from './payment-record.vue'
  var tokens = document.getElementsByName('csrf-token')
  if (tokens.length) {
    axios.defaults.headers['X-CSRF-Token'] = tokens.item(0).content
  }
  export default {
    components: {
      WorkerBasicInfo,
      WorkingRecord,
      PaymentRecord
    },
    props: [
      'workerList',
    ],
    data: function () {
      const worker_list = JSON.parse(this.workerList)
      return {
        collapsed: new Array(worker_list.length).fill(true),
        worker_list: worker_list,
        working_records: [],
        payment_records: [],
        current_open_index: 0,
        workerRecordsActive: true,
        paymentRecordsActive: false,
        current_worker: {
          id: '',
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
          .then(({data, _status}) => {
            if (vm.current_open_index !== 0) {
              vm.$set(vm.collapsed, vm.current_open_index, !vm.collapsed[vm.current_open_index])
            }
            vm.current_open_index = index
            vm.current_worker = data.worker
            vm.$set(vm.collapsed, index, !vm.collapsed[index])
            vm.working_records = data.working_records
          })
          .catch(() => {
          })
      },
      show_payment_records: function() {
        this.workerRecordsActive = false;
        this.paymentRecordsActive = true;
      },
      show_worker_records: function() {
        this.workerRecordsActive = true;
        this.paymentRecordsActive = false;
      },
    }
  }
</script>

<style scoped>
</style>
