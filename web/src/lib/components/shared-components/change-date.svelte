<script lang="ts" context="module">
  // eslint-disable-next-line @typescript-eslint/no-namespace
  declare namespace Intl {
    type Key = 'calendar' | 'collation' | 'currency' | 'numberingSystem' | 'timeZone' | 'unit';
    function supportedValuesOf(input: Key): string[];
  }
</script>

<script lang="ts">
  import { createEventDispatcher } from 'svelte';
  import { DateTime } from 'luxon';
  import ConfirmDialogue from './confirm-dialogue.svelte';
  import Dropdown from '../elements/dropdown.svelte';
  export let initialDate: DateTime = DateTime.now();

  interface ZoneOption {
    zone: string;
    offset: string;
  }

  const timezones: ZoneOption[] = Intl.supportedValuesOf('timeZone').map((zone: string) => ({
    zone,
    offset: 'UTC' + DateTime.local({ zone }).toFormat('ZZ'),
  }));

  const initialOption = timezones.find((item) => item.offset === 'UTC' + initialDate.toFormat('ZZ'));

  let selectedDate = initialDate.toFormat("yyyy-MM-dd'T'HH:mm");
  let selectedTimezone = initialOption?.offset || null;
  let disabled = false;

  let searchQuery = '';
  let filteredTimezones: ZoneOption[] = timezones;

  const updateSearchQuery = (event: Event) => {
    searchQuery = (event.target as HTMLInputElement).value;
    filterTimezones();
  };

  const filterTimezones = () => {
    filteredTimezones = timezones.filter((timezone) => timezone.zone.toLowerCase().includes(searchQuery.toLowerCase()));
  };

  const dispatch = createEventDispatcher<{
    cancel: void;
    confirm: string;
  }>();

  const handleCancel = () => dispatch('cancel');
  const handleConfirm = () => {
    let date = DateTime.fromISO(selectedDate);
    if (selectedTimezone != null) {
      date = date.setZone(selectedTimezone, { keepLocalTime: true }); // Keep local time if not it's really confusing
    }

    const value = date.toISO();
    if (value) {
      disabled = true;
      dispatch('confirm', value);
    }
  };
  const handleKeydown = (event: KeyboardEvent) => {
    if (['ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight'].includes(event.key)) {
      event.stopPropagation();
    }
  };
  let isDropdownOpen = false;

  const openDropdown = () => {
    isDropdownOpen = true;
  };

  const closeDropdown = () => {
    isDropdownOpen = false;
  };

  const handleSelectTz = (item: ZoneOption) => {
    selectedTimezone = item.offset;
    closeDropdown();
  };
</script>

<div role="presentation" on:keydown={handleKeydown}>
  <ConfirmDialogue
    confirmColor="primary"
    cancelColor="secondary"
    title="Change Date"
    prompt="Please select a new date:"
    {disabled}
    on:confirm={handleConfirm}
    on:cancel={handleCancel}
  >
    <div class="flex flex-col text-md px-4 py-5 text-center gap-2" slot="prompt">
      <div class="mt-2" />
      <div class="flex flex-col">
        <label for="datetime">Date and Time</label>
        <input
          class="immich-form-label text-sm mt-2 w-full text-black"
          id="datetime"
          type="datetime-local"
          bind:value={selectedDate}
        />
      </div>
      <div class="flex flex-col w-full">
        <label for="timezone">Timezone</label>
        <div class="relative">
          <input
            class="immich-form-label text-sm mt-2 w-full text-black"
            id="timezoneSearch"
            type="text"
            placeholder="Search timezone..."
            bind:value={searchQuery}
            on:input={updateSearchQuery}
            on:focus={openDropdown}
          />
          <Dropdown
            selectedOption={initialOption}
            options={filteredTimezones}
            render={(item) => (item ? `${item.zone} (${item.offset})` : '(not selected)')}
            on:select={({ detail: item }) => handleSelectTz(item)}
            controlable={true}
            bind:showMenu={isDropdownOpen}
          />
        </div>
      </div>
    </div>
  </ConfirmDialogue>
</div>
