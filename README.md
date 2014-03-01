# Stripe
A work in progress for using Elixir with the Stripe API. So far there is only
Customer creation, deletion and updating.

Since this is only a thing wrapper around Stripe everything passed to and returned by
Stripe should be a HashDict.

## Usage
Before you do anything you have to set your API token. If you're running the tests
(they actually hit the API at the moment) you need to set an environment variable called
`STRIPE_SECRET_KEY` before you run the tests. You can also just modify the test_helper and
pass the key there.

```elixir
Stripe.set_secret("Your Secret Here")
```

### Creating a Customer

```elixir
attrs = HashDict.new([
  email: 'foo@bar.com',
  description: 'New user'
])

{:ok, customer} = Stripe.Customer.create(attrs)
IO.puts HashDict.get(customer, "email") # foo@bar.com
```

### Updating a Customer

```elixir
attrs = HashDict.new([
  email: 'foo1@bar.com',
  description: 'Updated description'
])

{:ok, customer} = Stripe.Customer.update("cus_3aDRxsZH8sTV6F", attrs)
```

### Deleting a Customer

```elixir
id = "cus_3aDRxsZH8sTV6F"
{:ok, message} = Stripe.Customer.delete(id)
```

### Retrieving a Customer

```elixir
id = "cus_3aDRxsZH8sTV6F"
{:ok, customer} = Stripe.Customer.retrieve(id)
```

### Listing Customers

```elixir
{:ok, customers} = Stripe.Customer.list
```

All implemented API methods use the same names as above when applicable except
Cards, Discounts, and Subscriptions which each take a `customer_id` as their
first argument.

## Todo

* Document existing code

The following parts of the API need to be implemented

* Charges
* ~~Customers~~
* ~~Cards~~
* Subscriptions
* Plans
* Coupons
* Discounts
* Invoices
* Invoice Items
* Disputes
* Transfers
* Recipients
* Application Fees
* Account
* Balance
* Events
* Tokens
