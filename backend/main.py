import datetime
import time
import json
def getDateTime(seconds):
    return datetime.datetime.fromtimestamp(seconds)

def date_range(start, end):
    r = (end+datetime.timedelta(days=1)-start).days
    return [start+datetime.timedelta(days=i) for i in range(r)]

def hours_delta(dt1, dt2):
    return abs(dt1.hour - dt2.hour)

def days_delta(dt1, dt2):
    return abs(dt1.day - dt2.day)

def time_to_string(time):
    return time.strftime("%I:%M %p")

def get_days(last_wake_time, shift_start_day, shift_start_time):
    print(last_wake_time)
    print(shift_start_day)
    print(shift_start_time)
    dates_between = date_range(last_wake_time, shift_start_day)[1:]
    delta_hours = hours_delta(last_wake_time, shift_start_time)
    offset = (delta_hours / float(len(dates_between))) * 60.0 * 60.0
    days = []
    for index, d in enumerate(dates_between):
        day = {}

        day['day'] = d.strftime("%-m/%-d")

        events = []

        last_wake_time = last_wake_time + datetime.timedelta(0, offset)
        wake_up_event = {}
        wake_up_event['iconName'] = 'wake'
        wake_up_event['timeText'] = time_to_string(last_wake_time)
        wake_up_event['name'] = "Wake Up!"
        events.append(wake_up_event)

        bright_light_time = last_wake_time + datetime.timedelta(hours=2)
        bright_light_event = {}
        bright_light_event['iconName'] = 'light'
        bright_light_event['timeText'] = time_to_string(last_wake_time) + "-" + time_to_string(bright_light_time)
        bright_light_event['name'] = "See Bright Light"
        events.append(bright_light_event)

        caffeine_time = last_wake_time + datetime.timedelta(hours=4)
        caffeine_event = {}
        caffeine_event['iconName'] = 'caffeine'
        caffeine_event['timeText'] = time_to_string(last_wake_time) + "-" + time_to_string(caffeine_time)
        caffeine_event['name'] = "Get Caffeine"
        events.append(caffeine_event)

        melatonin_time = last_sleep_time - datetime.timedelta(hours=1)
        melatonin_event = {}
        melatonin_event['iconName'] = 'melatonin'
        melatonin_event['timeText'] = time_to_string(melatonin_time)
        melatonin_event['name'] = 'Take Melatonin'
        if(melatonin_time.day != last_wake_time.day):
            if index != 0:
                days[index - 1]['events'].append(melatonin_event)
        else:
            events.append(melatonin_event)

        last_sleep_time = last_wake_time - datetime.timedelta(hours=7)
        sleep_event = {}
        sleep_event['iconName'] = 'sleep'
        sleep_event['timeText'] = time_to_string(last_sleep_time)
        sleep_event['name'] = 'Bed Time'
        if(last_sleep_time.day != last_wake_time.day):
            if index != 0:
                days[index - 1]['events'].append(sleep_event)
        else:
            events.append(sleep_event)

        day['events'] = events
        days.append(day)
    return days

print(get_days(getDateTime(1588438800), getDateTime(1588917788), getDateTime(1588485788.3343191)))


def algorithm(request):

    output = { 'days': [] }

    print(request.json)

    # wake up, bedtime
    last_sleep_time = getDateTime(request.json.get("lastSleep"))
    last_wake_time = getDateTime(request.json.get("lastWake"))

    for shift in request.json.get("shifts"):
        print(shift)
        shift_start_time = getDateTime(shift["startTime"])
        shift_start_day = getDateTime(shift["startDay"])

        output['days'] = get_days(last_wake_time, shift_start_day, shift_start_time)

    return json.dumps(output)
