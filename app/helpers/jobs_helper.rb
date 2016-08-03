module JobsHelper

  def featured_jobs(count = 8)
    featured_jobs =
        Job
            .eager_loaded
            .where(active: true, is_featured: true)
            .reorder('listings.featured_last_shown ASC NULLS FIRST')
            .limit(count)
            .to_a

    Listing.where('id in (?)', featured_jobs.map{ |job| job.listing.id }).update_all(featured_last_shown:  Time.now)
    featured_jobs
  end

  def latest_jobs(limit = 10)
    Job
        .eager_loaded
        .where(active: true)
        .limit(limit)
        .to_a
  end

  def other_jobs_from_employer(job)
    job.employer.jobs.active.all_except(job).limit(5)
  end

  def similar_jobs(job)
    Job.active.in_community(job.community_ids).all_except(job).reorder('RANDOM()').limit(5)
  end

  def suggested_jobs(job_seeker)
    community_ids = job_seeker.resumes.collect { |r| r.communities.ids}.flatten
    community_ids.empty? ?
        [] :
        Job.active.in_community(community_ids).reorder('RANDOM()').limit(3)
  end

end
