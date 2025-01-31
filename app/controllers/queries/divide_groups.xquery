let $students := doc("../../../data_generated/students/Students_GINF2.xml")//Student
let $group-size := 2
let $total-groups := count($students) div $group-size

return
<TPGroups>
  {
    for $i in 1 to $total-groups
    return
      <Group id="{ $i }">
        {
          for $j in (($i - 1) * $group-size + 1) to ($i * $group-size)
          return $students[$j]
        }
      </Group>
  }
</TPGroups>
