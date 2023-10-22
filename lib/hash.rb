class Hash

  # Transform {"17 Oct 2023"=>1, "18 Oct 2023"=>1, "19 Oct 2023"=>1, "20 Oct 2023"=>1}
  # into {"17 Oct 2023"=>1, "18 Oct 2023"=>2, "19 Oct 2023"=>3, "20 Oct 2023"=>4}
  def accumulate!
    cumulative = 0
    transform_values! { |v| cumulative += v }
  end

end
