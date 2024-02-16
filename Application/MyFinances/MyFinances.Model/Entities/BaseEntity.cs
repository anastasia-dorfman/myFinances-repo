namespace MyFinances.Model
{
    public class BaseEntity
    {
        public List<ValidationError> Errors = new();

        public void AddError(ValidationError error)
        {
            Errors.Add(error);
        }
    }
}
