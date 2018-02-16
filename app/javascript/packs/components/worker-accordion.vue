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
        <tr :key="col.id" v-on:click="open_worker_info(index, col.id)" class="c-p">
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
              <button type="button" v-on:click="show_prepayment_applications" class="btn col-4 offset-1" v-bind:class='{ "btn-primary": prepaymentApplicationsActive }'>前払金ログ</button>
              <button type="button" v-on:click="show_worker_records" class="btn btn- col-4 offset-2" v-bind:class='{ "btn-primary": workerRecordsActive }'>出席ログ</button>
            </div>
            <span id="working_records_span" v-if="workerRecordsActive">
                <working-record :working-records='working_records'
                            :worker='current_worker'
                            ></working-record>
            </span>
            <span id="prepayment_applications_span" v-if="prepaymentApplicationsActive">
                <payment-record :prepayment-applications='prepayment_applications'
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
import axios from "axios";
import WorkerBasicInfo from "./worker-basic-info.vue";
import WorkingRecord from "./working-record.vue";
import PaymentRecord from "./payment-record.vue";
var tokens = document.getElementsByName("csrf-token");
if (tokens.length) {
  axios.defaults.headers["X-CSRF-Token"] = tokens.item(0).content;
}
export default {
  components: {
    WorkerBasicInfo,
    WorkingRecord,
    PaymentRecord
  },
  props: ["workerList"],
  data: function() {
    const worker_list = JSON.parse(this.workerList);
    return {
      collapsed: new Array(worker_list.length).fill(true),
      worker_list: worker_list,
      working_records: [],
      prepayment_applications: [],
      current_open_index: 0,
      workerRecordsActive: true,
      prepaymentApplicationsActive: false,
      current_worker: {
        id: "",
        uid: "",
        name: "",
        address: "",
        branch_name: "",
        emai: "",
        entrance_date: "",
        hourly_pay: "",
        birthday: "",
        bank_account: ""
      }
    };
  },
  created: function() {},
  methods: {
    open_worker_info: function(index, worker_id) {
      var vm = this;
      axios
        .get("/api/customer/worker_record/" + worker_id)
        .then(({ data, _status }) => {
          vm.current_worker = data.worker;
          vm.working_records = data.working_records;
          if (!vm.collapsed[index]) {
            // accordion was open
            vm.$set(vm.collapsed, vm.current_open_index, true);
            return;
          } else {
            // accordion was closed
            vm.$set(vm.collapsed, vm.current_open_index, true);
            vm.current_open_index = index;
            vm.$set(vm.collapsed, index, false);
          }
        })
        .catch(() => {});
      axios
        .get("/api/customer/prepayment/" + worker_id)
        .then(({ data, _status }) => {
          vm.prepayment_applications = data.prepayment_applications;
        })
        .catch(() => {});
    },
    show_prepayment_applications: function() {
      this.workerRecordsActive = false;
      this.prepaymentApplicationsActive = true;
    },
    show_worker_records: function() {
      this.workerRecordsActive = true;
      this.prepaymentApplicationsActive = false;
    }
  }
};
</script>

<style scoped>

</style>
