namespace MyFinances.Model
{
    public class Account
    {
        public int AccountId { get; set; }
        public string Name { get; set; }
        public string? AccountType { get; set; }
        public string Institution { get; set; }
        public decimal CreditLimit { get; set; }
    }
}
