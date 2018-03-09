<template>
  <table class="table table-striped table-hover">
    <tbody>
      <tr>
        <th class="w40 text-center" colspan="3">Notice</th>
      </tr>
      <template v-for="(col, index) in list">
        <tr :key="col.id" v-on:click="openCloseAccordion(index)" class="c-p">
          <td class="text-center" width="10%">
            <i
              class="fa"
              v-bind:class="{'fa-plus':collapsed[index], 'fa-minus':!collapsed[index]}"
              aria-hidden="true"></i>
          </td>
          <td width="20%">{{ formatDate(col.published_date) }}</td>
          <td width="70%">{{ col.title }}</td>
        </tr>
        <tr v-show="!collapsed[index]" :key="col.id">
          <td colspan="3">{{ col.content }}</td>
        </tr>
      </template>
    </tbody>
  </table>
</template>

<script>
import moment from 'moment'
export default {
  props: ["informationList"],
  data: function() {
    const informationList = JSON.parse(this.informationList);
    return {
      collapsed: new Array(informationList.length).fill(true),
      current_open_index: 0,
      list: informationList
    };
  },
  created: function() {},
  methods: {
    openCloseAccordion: function(index) {
      if (!this.collapsed[index]) { // accordion was open
        this.$set(this.collapsed, this.current_open_index, true);
      } else {                      // accordion was closed
        this.$set(this.collapsed, this.current_open_index, true);
        this.current_open_index = index;
        this.$set(this.collapsed, index, false);
      }
    },
    formatDate: function(date) {
      return moment.utc(date).format("YYYY-MM-DD")
    }
  }
};
</script>

<style scoped>

</style>
