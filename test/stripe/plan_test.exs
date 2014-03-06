defmodule Stripe.PlanTest do
  use ExUnit.Case
  use ExVCR.Mock

  teardown do
    use_cassette "delete plan setup" do
      Stripe.Plan.delete("new_plan")
    end
  end

  test "list plans" do
    create_plan

    use_cassette "list plans" do
      { :ok, plans } = Stripe.Plan.list

      assert HashDict.get(plans, "count") > 0
    end
  end

  test "create a plan" do
    create_plan

    use_cassette "create plan" do
      id = "create_a_plan"

      attrs = HashDict.new([
        id: id,
        name: "Create a Plan",
        amount: 1000,
        currency: "USD",
        interval: "week"
      ])

      { :ok, plan } = Stripe.Plan.create(attrs)

      assert HashDict.get(plan, "interval")  == "week"

      Stripe.Plan.delete(id)
    end
  end

  test "retrieve a plan" do
    id = create_plan

    use_cassette "retrieve plan" do
      { :ok, plan } = Stripe.Plan.retrieve(id)

      assert HashDict.get(plan, "id") == id
    end
  end

  test "update a plan" do
    id = create_plan

    use_cassette "update plan" do
      attrs = HashDict.new([name: "New name!"])

      { :ok, plan } = Stripe.Plan.update(id, attrs)

      assert HashDict.get(plan, "name") == "New name!"
    end
  end

  test "delete a plan" do
    use_cassette "delete plan" do
      attrs = HashDict.new([
        id: "delete_plan",
        name: "Delete Plan",
        amount: 1000,
        currency: "USD",
        interval: "week"
      ])

      { :ok, plan } = Stripe.Plan.create(attrs)
      id = HashDict.get(plan, "id")


      { :ok, plan } = Stripe.Plan.delete(id)
    end
  end


  defp create_plan do
    [do: id] = use_cassette "create plan helper" do
      attrs = HashDict.new([
        id: "new_plan",
        name: "New Plan",
        amount: 1000,
        currency: "USD",
        interval: "week"
      ])

      { :ok, plan } = Stripe.Plan.create(attrs)
      HashDict.get(plan, "id")
    end

    id
  end
end
