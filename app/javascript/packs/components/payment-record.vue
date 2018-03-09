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
            <th scope="col">前払い給与</th>
            <th scope="col">状態</th>
            <th scope="col">&nbsp;</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="prepayment_application in prepayment_applications" :key="prepayment_application.id">
            <td>{{ prepayment_application.created_date }}</td>
            <td>{{ prepayment_application.amount }}円</td>
            <td>{{ prepayment_application.status | option_status_label }}</td>
            <td>
              <button
                v-if="prepayment_application.status != 'approved'" 
                @click.prevent.self="prepayment_application_edit_open(worker, prepayment_application)" 
                class="btn btn-info">
                修正
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <b-modal ref="prepayment_application_edit"
                     :hide-footer=true
                     :size="'lg'">
      <div slot="modal-title">
        {{ modal_data.name }}さんの{{modal_data.created_date}}の記録を修正する
      </div>
      <div class="form-group row">
        <label for="status" class="col-4 offset-2 col-form-label mt5">状態</label>
        <div class="col-6">
          <select v-model="modal_selected" class="form-control" id="status">
            <option v-for="option in options" v-bind:value="option.value" :key="option.id">
              {{ option.text }}
            </option>
          </select>
        </div>
      </div>
      <div class="form-group row my-4">
        <button type="submit" class="btn btn-warning col-4 offset-4" @click="update_prepayment_application">送信</button>
      </div>
    </b-modal>
  </div>
</template>

<script>
import axios from "axios";
import bootstrapModal from "vue2-bootstrap-modal";
import VueTimepicker from "vue2-timepicker";

export default {
  template: "...",
  components: {
    bootstrapModal,
    VueTimepicker
  },
  props: ["prepaymentApplications", "worker"],
  data() {
    return {
      current_month: new Date(),
      month_diff: 0,
      prepayment_applications: this.prepaymentApplications,
      worker_id: this.worker.id,
      modal_data: {
        id: "",
        name: "",
        created_date: ""
      },
      modal_selected: "",
      options: [{ text: "waiting", value: 0 }, { text: "rejected", value: 1 }]
    };
  },
  filters: {
    option_status_label: function(name) {
      switch (name) {
        case "approved":
          return "支払い済";
        case "rejected":
          return "不承認";
        default:
          return "承認済み";
      }
    }
  },
  created() {},
  methods: {
    update_date(increment) {
      let diff = this.month_diff + increment;
      axios
        .get(
          "/api/customer/prepayment/" + this.worker_id + "?month_diff=" + diff
        )
        .then(({ data, _status }) => {
          this.prepayment_applications = data.prepayment_applications;
          this.current_month = new Date(
            this.current_month.setMonth(
              this.current_month.getMonth() + increment
            )
          );
          this.month_diff += increment;
        })
        .catch(() => {});
    },
    older_than_current_month() {
      let today = new Date();
      if (this.current_month < today.setMonth(today.getMonth() - 1)) {
        return false;
      }
      return true;
    },
    prepayment_application_edit_open(worker, prepayment_application) {
      this.modal_data.name = worker.name;
      this.modal_data.id = prepayment_application.id;
      this.modal_data.created_date = prepayment_application.created_date;
      this.modal_selected = prepayment_application.status == "waiting" ? 0 : 1;
      this.$refs.prepayment_application_edit.show();
    },
    update_prepayment_application() {
      axios
        .put("/api/customer/prepayment/" + this.worker_id, {
          rejected: this.modal_selected,
          id: this.modal_data.id
        })
        .then(({ _data, _status }) => {
          let index = this.prepayment_applications.findIndex(
            item => item.id === this.modal_data.id
          );
          let entry = Object.assign({}, this.prepayment_applications[index]);
          entry.status = this.options[this.modal_selected].text;
          this.$set(this.prepayment_applications, index, entry);
          this.$refs.prepayment_application_edit.hide();
          // alert(data.message)
        })
        .catch(_error => {
          // console.log(error);
        });
    }
  }
};
</script>

<style scoped>

</style>

