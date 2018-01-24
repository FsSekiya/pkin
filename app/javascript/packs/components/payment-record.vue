<template>
  <div class='accordion p10'>
    <h3 class="bg-white text-center w300 m-center lh50 mt20 mb10 row">
      <span class="c-p col-md-2" v-on:click="update_date(-1)">◀</span>
      <span class="col-md-8">{{current_month.getFullYear()}}年{{current_month.getMonth()+1}}月</span>
      <span class="c-p col-md-2" v-on:click="update_date(1)" v-if="!older_than_current_month()">▶</span>
    </h3>
    <div>
      <table class="table table-bordered table-striped">
        <thead>
          <tr>
            <th scope="col" class="w150">日付</th>
            <th scope="col">給与</th>
            <th scope="col">Payment?</th>
            <th scope="col">&nbsp;</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="prepayment_application in prepayment_applications" :key="prepayment_application.id">
            <td>{{ prepayment_application.created_date }}</td>
            <td>unknown</td>
            <td>{{ prepayment_application.amount }}</td>
            <td>
              <button @click.prevent.self="prepayment_application_edit_open(worker, prepayment_application)" class="btn btn-info">修正</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
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
      'prepaymentApplications',
      'worker'
    ],
    data: function () {
      return {
        current_month: (new Date()),
        month_diff: 0,
        prepayment_applications: this.prepaymentApplications,
        worker_id: this.worker.id,
        token: axios.defaults.headers['X-CSRF-Token']
      }
    },
    created: function () {
    },
    methods: {
      update_date: function(increment) {
        var vm = this
        let diff = vm.month_diff + increment
        axios
          .get('/api/customer/prepayment/' + vm.worker_id + '?month_diff=' + diff)
          .then(({data, _status}) => {
            vm.prepayment_applications = data.prepayment_applications
            vm.current_month = new Date(vm.current_month.setMonth(vm.current_month.getMonth() + increment))
            vm.month_diff += increment
          })
          .catch(() => {
          })
      },
      older_than_current_month: function() {
        let today = new Date();
        if (this.current_month < today.setMonth(today.getMonth() - 1)) {
          return false;
        }
        return true;
      }
    }
  }
</script>

<style scoped>
</style>

